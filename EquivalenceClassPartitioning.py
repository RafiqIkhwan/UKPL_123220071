from decimal import Decimal, InvalidOperation

# Fungsi untuk menghitung hasil penjumlahan atau pengurangan
def hitung(angka1, angka2, operasi):
    try:
        # Cek jika input berupa pecahan (misal "3/4")
        if '/' in angka1:
            a, b = map(float, angka1.split('/'))
            angka1 = str(a / b)
        if '/' in angka2:
            a, b = map(float, angka2.split('/'))
            angka2 = str(a / b)

        # Konversi ke desimal agar lebih akurat
        angka1 = Decimal(angka1)
        angka2 = Decimal(angka2)

        # Lakukan operasi sesuai permintaan
        if operasi == '+':
            return float(angka1 + angka2)
        elif operasi == '-':
            return float(angka1 - angka2)
        else:
            return "Operasi tidak valid"
    except Exception as e:
        return f"Terjadi kesalahan: {e}"

# Daftar 10 test case berdasarkan kelas ekuivalen input
test_case = [
    ("10", "5", "+"),          # 1. bilangan bulat valid
    ("10.5", "2.5", "-"),      # 2. bilangan desimal valid
    ("3/4", "1/4", "+"),       # 3. input pecahan valid
    ("abc", "5", "+"),         # 4. huruf sebagai input (tidak valid)
    ("", "5", "+"),            # 5. input kosong
    ("5", "0/0", "+"),         # 6. pembagian nol (error)
    ("-10", "3", "-"),         # 7. angka negatif
    ("1000000000000", "2", "+"),  # 8. angka sangat besar
    ("5.5", "abc", "-"),       # 9. satu input valid, satu tidak valid
    ("3.14", "2.71", "+"),     # 10. bilangan pecahan non-pecahan (π dan e) valid
]

# Jalankan seluruh test case
for i, (a1, a2, op) in enumerate(test_case, 1):
    print(f"Test Case {i}: {a1} {op} {a2} = {hitung(a1, a2, op)}")
