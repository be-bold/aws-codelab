FROM nginx

ARG SERVICE_VERSION

COPY default.conf /etc/nginx/conf.d

# replace <SERVICE_VERSION> in default.conf with the service version
RUN sed -i "s/<SERVICE_VERSION>/${SERVICE_VERSION}/g" /etc/nginx/conf.d/default.conf