import fitz  # PyMuPDF
from googletrans import Translator
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfbase import pdfmetrics
from reportlab.lib.utils import ImageReader

# Initialize translator
translator = Translator()

# Open the PDF file
input_pdf_path = 'PAPER EXAM-DWA study notes.pdf'
output_pdf_path = 'translated_output_file.pdf'

# Read the PDF
doc = fitz.open(input_pdf_path)
translated_texts = []

# Extract text and translate
for page_num in range(len(doc)):
    page = doc.load_page(page_num)
    text = page.get_text("text")
    translated = translator.translate(text, src='en', dest='vi').text
    translated_texts.append(translated)

# Create a new PDF with translated text and images using reportlab
pdf = canvas.Canvas(output_pdf_path, pagesize=letter)

# Register and use the "Times New Roman" font
pdfmetrics.registerFont(TTFont('TimesNewRoman', 'times.ttf'))
pdf.setFont("TimesNewRoman", 12)

# Add translated text and images to the new PDF
for page_num in range(len(doc)):
    page = doc.load_page(page_num)
    # Get the translated text
    translated_text = translated_texts[page_num]
    lines = translated_text.split('\n')

    # Write translated text to the PDF
    y = 750  # Start writing from top of the page
    for line in lines:
        if y < 50:  # If we're getting close to the bottom of the page, add a new page
            pdf.showPage()
            pdf.setFont("TimesNewRoman", 12)
            y = 750
        pdf.drawString(30, y, line)
        y -= 15

    # Add images to the PDF
    image_list = page.get_images(full=True)
    for img in image_list:
        xref = img[0]
        base_image = doc.extract_image(xref)
        image_bytes = base_image["image"]
        image_ext = base_image["ext"]
        image = ImageReader(io.BytesIO(image_bytes))
        
        # Get image dimensions and position
        rect = fitz.Rect(img[2], img[3], img[4], img[5])
        pdf.drawImage(image, rect.x0, rect.y0, rect.width, rect.height)

    pdf.showPage()

# Save the PDF
pdf.save()

print(f"Translated PDF saved as {output_pdf_path}")
