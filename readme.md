# 🧪 Fake Person Generator

A slick, dark-themed Django web app that creates realistic U.S. identities with a click.  
Perfect for testing, prototyping, or when you just need a fake Jeffrey 👤

---

## ✨ Features

- ✅ Realistic U.S. Names (via Faker)
- 🔢 Gender, DOB, Email & Secure Password
- 📬 Gmail-style email generation
- 🔒 16+ character strong password
- 🌑 Responsive dark UI
- 📋 One-click copy buttons

---

## ⚙️ Requirements

- Python 3.10+
- Django 4.2+
- Faker

Install:

```bash
pip install -r requirements.txt
```

---

## 🚀 Local Development

```bash
git clone https://github.com/frymex/fakeUSGenerator.git
cd fakeUSGenerator

python -m venv .venv
source .venv/bin/activate

pip install -r requirements.txt
python manage.py collectstatic --noinput
python manage.py runserver
```

Now visit: [http://127.0.0.1:8000](http://127.0.0.1:8000)

---

## 🐳 Run with Docker

```bash
./build.sh faker.cazqev.pro
```

This will:

- Replace domain in nginx config
- Build & start Docker containers
- Serve app at `http://faker.cazqev.pro`

> Requires `docker` and `docker-compose` installed.

---

## 🎨 Customize

- Change styles in `static/css/style.css`
- Modify password logic in `generator/utils.py`
- Update email rules or locales in `Faker`

---

Enjoy building fake identities responsibly 😄
