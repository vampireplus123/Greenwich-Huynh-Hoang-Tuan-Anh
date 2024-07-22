import fitz  # PyMuPDF
from googletrans import Translator
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfbase import pdfmetrics

# Initialize translator
translator = Translator()

# Open the PDF file
input_pdf_path = 'PAPER EXAM-DWA study notes.pdf'
output_pdf_path = 'translated_output_file.pdf'

# Read the PDF
doc = fitz.open(input_pdf_path)
translated_text = ""

# Extract text and translate
for page_num in range(len(doc)):
    page = doc.load_page(page_num)
    text = page.get_text()
    translated = translator.translate(text, src='en', dest='vi').text
    translated_text += translated + "\n\n"

# Create a new PDF with translated text using reportlab
pdf = canvas.Canvas(output_pdf_path, pagesize=letter)

# Register and use the "Times New Roman" font
pdfmetrics.registerFont(TTFont('TimesNewRoman', 'times.ttf'))
pdf.setFont("TimesNewRoman", 12)

# Write the translated text to the PDF
lines = translated_text.split('\n')
y = 750  # Start writing from top of the page
for line in lines:
    if y < 50:  # If we're getting close to the bottom of the page, add a new page
        pdf.showPage()
        pdf.setFont("TimesNewRoman", 12)
        y = 750
    pdf.drawString(30, y, line)
    y -= 15

# Save the PDF
pdf.save()

print(f"Translated PDF saved as {output_pdf_path}")
