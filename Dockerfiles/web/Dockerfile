FROM nginx:latest
LABEL "Author"="uday"
LABEL "project"="vprofile"

RUN rm -rf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/vproapp.conf

