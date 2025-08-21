# Database-MySQL

📚 مستودع تعليمي يحتوي على **أكواد SQL** مخصصة للتعلّم والتدريب على MySQL.
هنا ستجد سكربتات عملية تشمل إنشاء الجداول، العلاقات، الاستعلامات الأساسية والمتقدمة، مع أمثلة واقعية تساعدك على فهم مفاهيم قواعد البيانات بشكل تدريجي.

---

## ✨ الهدف

* تعلم **أساسيات MySQL** (إنشاء قاعدة بيانات، جداول، مفاتيح).
* ممارسة **أوامر DDL وDML** مثل `CREATE`, `INSERT`, `UPDATE`, `DELETE`.
* التدرب على **الاستعلامات**: `SELECT`, `JOIN`, `GROUP BY`, `ORDER BY`.
* الاطلاع على أمثلة **قيود العلاقات** (Primary Key, Foreign Key).
* استخدام نسخ احتياطية ومخططات ERD لفهم البنية بشكل بصري.

---

## 📂 بنية المستودع

```
Database-MySQL/
├── Backup/                   # نسخ احتياطية SQL جاهزة للاستيراد
├── Course/                   # سكربتات تعليمية (أمثلة وأكواد الدروس)
├── Relational Scheme.drawio  # مخطط ERD قابل للتعديل
├── Relational Scheme.pdf     # نسخة PDF من المخطط
├── Relational Scheme.svg     # نسخة SVG من المخطط
└── README.md                 # هذا الملف
```

---

## 🛠️ المتطلبات

* MySQL 8.0 أو أحدث
* MySQL Workbench أو أي عميل SQL
* (اختياري) Docker لتشغيل MySQL سريعًا

---

## 🚀 البدء السريع

1. استنساخ المستودع:

```bash
git clone https://github.com/HamzaAlwajeeh/Database-MySQL.git
cd Database-MySQL
```

2. فتح ملفات السكربتات من مجلد `Course/` وتنفيذها في Workbench.

3. إنشاء قاعدة بيانات تدريبية:

```sql
CREATE DATABASE training_db;
USE training_db;
```

4. تشغيل سكربتات الجداول والعلاقات من مجلد `Course/`.

---

## 🧑‍💻 أمثلة من الأكواد

### إنشاء جدول طلاب:

```sql
CREATE TABLE students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### إدخال بيانات:

```sql
INSERT INTO students (name, email)
VALUES ('Ali Ahmed', 'ali@example.com');
```

### استعلامات أساسية:

```sql
SELECT * FROM students;
SELECT name FROM students WHERE email LIKE '%@example.com';
```

### العلاقات (مثال جدول المواد):

```sql
CREATE TABLE courses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL
);

CREATE TABLE student_courses (
  student_id INT,
  course_id INT,
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

---

## 📊 المخطط (ERD)

* متوفر بصيغ **drawio/pdf/svg**.
* يساعد على فهم العلاقات بين الجداول بشكل بصري.

---

## 📝 ملاحظات

* هذا المشروع **للتعلم فقط** وليس مشروع إنتاجي.


---

✍️**Hamza Alwajeeh**
