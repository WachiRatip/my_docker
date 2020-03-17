FROM python:3.7.7-slim

WORKDIR /home
VOLUME /home
EXPOSE 8888

COPY requirements.txt ./
RUN pip install -U pip && pip install --no-cache-dir -r requirements.txt

COPY /source ./

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]