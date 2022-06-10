# set the base image 
FROM python:3.7.4-alpine3.10

ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_PASSWORD=password
ENV DJANGO_SUPERUSER_EMAIL=admin@admin.com

#Seta o diretorio da aplicacao
WORKDIR /achallengew1

#Instala as dependencias do python
COPY requirements.txt /achallengew1/requirements.txt

# Get pip to download and install requirements:
RUN pip install --upgrade pip && pip install -r /achallengew1/requirements.txt

#Copia o conteudo da aplicacao para o diretorio definido anteriormente
COPY . /achallengew1
# Ajuda dos parceiros da Alura 
RUN sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['*']/" setup/settings.py
RUN python manage.py makemigrations && python manage.py migrate && python manage.py createsuperuser --noinput

# Expose ports
EXPOSE 8000


# default command to execute    
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
