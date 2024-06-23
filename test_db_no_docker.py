import psycopg2
import json

# Koneksi ke database PostgreSQL
conn = psycopg2.connect(
    dbname="einvoice",
    user="postgres",
    password="renbo123",
    host="localhost",
    port="5432"
)
cursor = conn.cursor()

# Fungsi untuk menyimpan data JSON dan file PDF ke dalam tabel input_invoices
def save_invoice(invoice_id, invoice_data, pdf_path):
    with open(pdf_path, 'rb') as pdf_file:
        pdf_data = pdf_file.read()

    cursor.execute("""
        INSERT INTO public.input_invoices (id_invoice, json_data, pdf_file)
        VALUES (%s, %s, %s)
    """, (invoice_id, json.dumps(invoice_data), psycopg2.Binary(pdf_data)))

    conn.commit()

# Fungsi untuk mengambil dan menampilkan data dari tabel input_invoices
def get_invoice(invoice_id, output_pdf_path):
    cursor.execute("""
        SELECT json_data, pdf_file
        FROM public.input_invoices
        WHERE id_invoice = %s
    """, (invoice_id,))
    record = cursor.fetchone()
    
    if record:
        invoice_data, pdf_data = record
        print("Invoice Data:", invoice_data)  # invoice_data sudah berupa dictionary

        with open(output_pdf_path, 'wb') as pdf_file:
            pdf_file.write(pdf_data)
        print(f"PDF file saved to {output_pdf_path}")
    else:
        print(f"Invoice with ID {invoice_id} not found.")

# Contoh penggunaan
invoice_id = "INV001"
invoice_data = {
    "customer": "John Doe",
    "amount": 1500,
    "items": [
        {"item": "Laptop", "price": 1000},
        {"item": "Mouse", "price": 500}
    ]
}
pdf_path = "input_invoice.pdf"
output_pdf_path = "retrieved_invoice.pdf"

# Simpan data JSON dan file PDF ke database
save_invoice(invoice_id, invoice_data, pdf_path)

# Ambil dan tampilkan data dari database
get_invoice(invoice_id, output_pdf_path)

# Tutup koneksi
cursor.close()
conn.close()
