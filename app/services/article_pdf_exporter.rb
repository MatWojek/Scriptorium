class ArticlePdfExporter
  DARK    = "252525"
  CARMINE = "9F1239"
  PAPER   = "FFFFFF"
  MUTED   = "888888"

  FONT_DIR = "/usr/share/fonts/truetype/dejavu"

  def initialize(article)
    @article = article
  end

  def generate
    # Generating the PDF
    Prawn::Document.new(page_size: "A4", margin: [30, 30, 30, 30]) do |pdf|
      register_fonts(pdf)
      draw_header(pdf)
      draw_meta(pdf)
      draw_images(pdf)
      draw_content(pdf)
      draw_footer(pdf)
    end.render
  end

  private

  def safe(str)
    str.to_s.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
  end

  def register_fonts(pdf)
    pdf.font_families.update(
      "DejaVu" => {
        normal: "#{FONT_DIR}/DejaVuSans.ttf",
        bold: "#{FONT_DIR}/DejaVuSans-Bold.ttf"
      }
    )
    pdf.font "DejaVu"
  end

  def draw_header(pdf)
    title = safe(@article.title)

    # Calculate height of text with width to match background
    box_width = pdf.bounds.width - 30
    height = pdf.height_of(title, width: box_width, size: 20)
    header_height = [height + 30, 70].max

    pdf.fill_color DARK 
    pdf.fill_rectangle [0, pdf.cursor], pdf.bounds.width, header_height
    pdf.fill_color PAPER 

    pdf.text_box title,
      at: [15, pdf.cursor - 15],
      width: box_width,
      height: header_height - 20,
      font: "DejaVu",
      style: :bold,
      size: 20,
      overflow: :shrink_to_fit,
      min_font_size: 12

    pdf.move_down header_height + 15
  end

  def draw_meta(pdf)
    parts = []
    parts << @article.user.username if @article.user
    parts << @article.created_at.strftime("%B %-d, %Y") if @article.created_at
    parts << @article.category.name if @article.respond_to?(:category) && @article.category
    parts << @article.language.name if @article.respond_to?(:language) && @article.language

    pdf.fill_color MUTED
    pdf.font("DejaVu", size: 9) do
      pdf.draw_text safe(parts.join("   ·   ")), at: [0, pdf.cursor]
    end

    pdf.move_down 10
    pdf.stroke_color CARMINE
    pdf.line_width 1
    pdf.stroke_line [0, pdf.cursor], [pdf.bounds.width, pdf.cursor]
    pdf.move_down 20
  end

  def draw_images(pdf)
    return unless @article.content.present?

    @article.content.body.attachables.each do |attachable|
      next unless attachable.respond_to?(:image?) && attachable.image?

      tmp = nil
      begin
        tmp = Tempfile.new(["article_img", ".jpg"])
        tmp.binmode
        tmp.write(attachable.download)
        tmp.close

        pdf.image tmp.path, fit: [pdf.bounds.width, 260]
        pdf.move_down 15
      rescue => e
        # skip images when is not available
      ensure
        tmp&.unlink
      end
    end
  end

  def draw_content(pdf)
    text = @article.content.present? ? @article.content.to_plain_text : ""

    pdf.fill_color DARK
    pdf.font("DejaVu", size: 11) do
      pdf.text safe(text), leading: 4
    end
  end

  def draw_footer(pdf)
    pdf.number_pages "Strona <page> z <total>",
      at: [pdf.bounds.right - 100, 0],
      width: 100,
      align: :right,
      size: 8,
      color: MUTED
  end
end