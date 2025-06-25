import random
import string
from faker import Faker

fake = Faker('en_US')

def generate_strong_password(length=16):
    chars = (
        string.ascii_lowercase +
        string.ascii_uppercase +
        string.digits +
        "!@#$%^&*()-_=+[]{};:,.<>?/"
    )
    pwd = [
        random.choice(string.ascii_lowercase),
        random.choice(string.ascii_uppercase),
        random.choice(string.digits),
        random.choice("!@#$%^&*()-_=+[]{}?/")
    ]
    pwd += random.choices(chars, k=length - 4)
    random.shuffle(pwd)
    return ''.join(pwd)

def generate_email(first_name, last_name):
    num = random.randint(10, 99)
    local = f"{first_name.lower()}.{last_name.lower()}{num}"
    return f"{local}@gmail.com"

def generate_person():
    gender = random.choice(['Male', 'Female'])
    fname = fake.first_name_male() if gender == 'Male' else fake.first_name_female()
    lname = fake.last_name()
    dob = fake.date_of_birth(minimum_age=18, maximum_age=90).strftime('%Y-%m-%d')
    email = generate_email(fname, lname)
    password = generate_strong_password()
    return {
        'first_name': fname,
        'last_name': lname,
        'gender': gender,
        'dob': dob,
        'email': email,
        'password': password
    }
