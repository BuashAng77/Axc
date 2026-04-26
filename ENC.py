import sys

def encrypt_xor(data, key=0x1F):
    return "".join(f"\\x{ord(c) ^ key:02x}" for c in data)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        webhook_url = input("Webhook: ").strip()
        if not webhook_url:
            print("Sử dụng: python webhook_enc.py <url>")
            sys.exit(1)
    else:
        webhook_url = sys.argv[1]

    enc_url = encrypt_xor(webhook_url)
    print(f"\nWebhook đã mã hóa:")
    print(enc_url)
    print()
