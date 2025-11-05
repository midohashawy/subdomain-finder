cat > sub_finder.sh <<'EOF'
#!/bin/bash

# Simple Subdomain Finder Script
# Usage: ./sub_finder.sh <domain>

if [ $# -eq 0 ]; then
    echo "How to use: ./sub_finder.sh <domain>"
    echo "Ex: ./sub_finder.sh www.megacorpone.com"
    exit 1
fi

domain=$1

echo "[*] Fetching main page for $domain ..."
wget -q -O index.html "http://$domain" || wget -q -O index.html "https://$domain"

echo "[*] Extracting possible subdomains..."
grep -Eo 'https?://[^"]+' index.html \
    | cut -d "/" -f 3 \
    | grep "$domain" \
    | sort -u > sub.txt

if [ ! -s sub.txt ]; then
    echo "[!] No subdomains found."
    exit 1
fi

echo "[*] Checking which subdomains are alive..."
> valid_sub.txt

while read -r sub; do
    if ping -c 1 -W 1 "$sub" &> /dev/null; then
        echo "[+] $sub is alive"
        echo "$sub" >> valid_sub.txt
    else
        echo "[-] $sub is unreachable"
    fi
done < sub.txt

echo "[*] Resolving IP addresses of valid subdomains..."
> ips.txt

while read -r sub; do
    host "$sub" | awk '/has address/ {print $4}' >> ips.txt
done < valid_sub.txt

echo "[*] Done!"
echo "Files created:"
echo " - sub.txt       (all found subdomains)"
echo " - valid_sub.txt (reachable subdomains)"
echo " - ips.txt       (IP addresses)"
EOF

chmod +x sub_finder.sh
