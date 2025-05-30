from decimal import Decimal

# Fungsi untuk melakukan kalkulasi penjumlahan dan pengurangan
def calculate(num1, num2, operation):
    try:
        # Ubah format pecahan (misal "3/4") ke angka desimal
        if '/' in num1:
            a, b = map(float, num1.split('/'))
            num1 = str(a / b)
        if '/' in num2:
            a, b = map(float, num2.split('/'))
            num2 = str(a / b)

        # Konversi ke Decimal untuk akurasi tinggi
        num1 = Decimal(num1)
        num2 = Decimal(num2)

        # Proses operasi berdasarkan simbol
        if operation == '+':
            return float(num1 + num2)
        elif operation == '-':
            return float(num1 - num2)
        else:
            return "Operasi tidak dikenali"
    except Exception as e:
        return f"Terjadi kesalahan: {e}"

# Kelas untuk Mesin Status (State Machine) Kalkulator
class KalkulatorStatus:
    def __init__(self):
        self.status = 'Idle'  # Status awal sistem
        self.angka1 = None
        self.angka2 = None
        self.hasil = None

    def masukkan_angka(self, angka):
        if self.status == 'Idle':
            self.angka1 = angka
            self.status = 'Input1Entered'
        elif self.status == 'Input1Entered':
            self.angka2 = angka
            self.status = 'Input2Entered'
        else:
            return "Transisi tidak valid"

    def hitung(self, operasi):
        if self.status == 'Input2Entered':
            self.hasil = calculate(self.angka1, self.angka2, operasi)
            self.status = 'Calculated'
            return self.hasil
        else:
            return "Tidak bisa melakukan operasi pada status saat ini"

# =======================
# Simulasi Transisi Valid
# =======================
print("=== Simulasi Transisi Valid ===")
fsm = KalkulatorStatus()
print(f"Status saat ini: {fsm.status}")

fsm.masukkan_angka("10")
print(f"Input angka pertama → Status: {fsm.status}")

fsm.masukkan_angka("5")
print(f"Input angka kedua → Status: {fsm.status}")

hasil = fsm.hitung('+')
print(f"Melakukan operasi → Status: {fsm.status} | Hasil: {hasil}")

# ==============================
# Simulasi Transisi Tidak Valid
# ==============================
print("\n=== Simulasi Transisi Tidak Valid ===")

# 1. Langsung hitung tanpa input angka
fsm1 = KalkulatorStatus()
print(f"\nTest 1 - Status: {fsm1.status}")
print(f"Langsung hitung: {fsm1.hitung('+')}")  # Harus gagal

# 2. Hitung setelah hanya input 1 angka
fsm2 = KalkulatorStatus()
fsm2.masukkan_angka("8")
print(f"\nTest 2 - Status: {fsm2.status}")
print(f"Coba hitung: {fsm2.hitung('-')}")  # Harus gagal

# 3. Masukkan angka lagi setelah hasil didapat
fsm3 = KalkulatorStatus()
fsm3.masukkan_angka("4")
fsm3.masukkan_angka("6")
fsm3.hitung('+')  # Sekarang status = Calculated
print(f"\nTest 3 - Status: {fsm3.status}")
print(f"Coba input angka setelah hasil: {fsm3.masukkan_angka('10')}")  # Harus gagal
