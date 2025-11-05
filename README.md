# subdomain-finder
Bash script that finds subdomains, pings them and resolves IPs
 الوصف
سكربت خفيف يحمّل الصفحة الرئيسية للدومين، يستخرج الروابط المحتملة التي تحتوي اسم الدومين، ثم:
- يجمع أسماء النطاق الفرعية في `sub.txt`
- يختبر الاستجابة لكل اسم (ping) ويحفظ الصالحة في `valid_sub.txt`
- يحل أسماء النطاق الفرعية الصالحة إلى عناوين IP في `ips.txt`

## المتطلبات
- bash
- wget
- grep, cut, sort, uniq, awk
- ping
- host (أو `dig` كبديل)

## طريقة الاستخدام
1. اجعل السكربت قابلًا للتنفيذ:
```bash
chmod +x sub_finder.sh
