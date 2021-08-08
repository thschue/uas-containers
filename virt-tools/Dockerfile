ARG ALPINE_VERSION=latest
ARG TERRAFORM_VERSION=1.0.4

FROM alpine:${ALPINE_VERSION} as builder
RUN apk add --no-cache curl

RUN mkdir /tmp/terraform \
   && curl -Lo /tmp/terraform/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
   && unzip /tmp/terraform/terraform.zip \
   && chmod a+x /tmp/terraform/terraform.zip
