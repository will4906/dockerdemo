FROM node:8 as builder

WORKDIR /app/web
ADD ./web /app/web

RUN npm config set sass_binary_site https://npm.taobao.org/mirrors/node-sass/
RUN npm install --registry=https://registry.npm.taobao.org

RUN npm run build
RUN npm cache clean --force \
 && rm -r ./node_modules


FROM python:3.7 as prod
ENV PYTHONUNBUFFERED 1

WORKDIR /app

ADD . /app
COPY --from=builder /app/web /app/web

RUN pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install gunicorn==19.9.0 -i https://pypi.tuna.tsinghua.edu.cn/simple

RUN python manage.py collectstatic --noinput
