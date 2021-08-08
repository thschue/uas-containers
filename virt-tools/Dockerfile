ARG ALPINE_VERSION=latest

FROM alpine:${ALPINE_VERSION} as builder

ARG TERRAFORM_VERSION=1.0.4

RUN apk add --no-cache curl

RUN mkdir /tmp/terraform \
   && curl -Lo /tmp/terraform/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
   && unzip /tmp/terraform/terraform.zip \
   && chmod a+x /tmp/terraform/terraform.zip

RUN mkdir /opt/gcloud \
  && curl https://sdk.cloud.google.com > install.sh \
  && ./install.sh --disable-prompts --install-dir /opt/gcloud

FROM alpine:${ALPINE_VERSION}

ENV PATH="/opt/gcloud:${PATH}"

COPY --from=builder /opt/gcloud /opt/gcloud
COPY --from=builder /tmp/terraform /usr/local/bin/terraform
