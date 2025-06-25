# 🧪 Fake Person Generator

A slick, dark-themed Django web app that creates realistic U.S. identities with a click.  
Perfect for testing, prototyping, or when you just need a fake Jeffrey 👤

---

## ✨ Features

- ✅ U.S. Realistic Names (via Faker)
- 🔢 Gender, DOB, Email & Secure Password
- 📬 Gmail-style Email Generation
- 🔒 16+ character password with symbols, numbers, and casing
- 🌑 Modern responsive dark UI
- 📋 One-click Copy for every field

---

## ⚙️ Requirements

- Python 3.10+
- Django 4.2+
- Faker

Install with:

```bash
pip install -r requirements.txt
```

---

## 🚀 Local Setup

1. **Clone the repo**

```bash
git clone https://github.com/frymex/fakeUSGenerator.git fake-person-generator
cd fake-person-generator
```

2. **Create virtual environment**

```bash
python -m venv .venv
source .venv/bin/activate   # Linux/macOS
.venv\Scripts\activate      # Windows
```

3. **Install dependencies**

```bash
pip install -r requirements.txt
```

4. **Run the server**

```bash
python manage.py runserver
```

Now visit [http://127.0.0.1:8000](http://127.0.0.1:8000) 🚪

---


## 🛠 Customize

- Change colors/fonts in `static/css/style.css`
- Adjust password rules in `generator/utils.py`
- Localize name generation by switching Faker locale


