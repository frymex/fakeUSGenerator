from django.shortcuts import render
from .utils import generate_person

def home(request):
    person = generate_person()
    return render(request, 'home.html', person)
