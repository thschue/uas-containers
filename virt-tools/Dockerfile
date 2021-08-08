ARG ALPINE_VERSION=latest

FROM alpine:${ALPINE_VERSION} as builder

ARG TERRAFORM_VERSION=1.0.4

RUN apk add --no-cache curl bash python3

RUN mkdir /tmp/terraform \
   && curl -Lo /tmp/terraform/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
   && unzip /tmp/terraform/terraform.zip -d /tmp/terraform \
   && ls /tmp/terraform \
   && chmod a+x /tmp/terraform/terraform

RUN mkdir /opt/gcloud && mkdir /tmp/gcloud-install \
  && curl https://sdk.cloud.google.com > /tmp/gcloud-install/install.sh \
  && ls /tmp/gcloud-install/ \
  && chmod a+x /tmp/gcloud-install/install.sh \
  && /tmp/gcloud-install/install.sh --disable-prompts --install-dir /opt/gcloud

FROM alpine:${ALPINE_VERSION}

ENV PATH="/opt/gcloud/google-cloud-sdk/bin:/home/labuser/.local/bin:${PATH}"

COPY .zshrc.template /tmp/.zshrc.template
COPY entrypoint.sh /entrypoint.sh
COPY --from=builder /opt/gcloud /opt/gcloud
COPY --from=builder /tmp/terraform/terraform /usr/local/bin/terraform

RUN apk add --no-cache bash zsh python3 curl git python3-dev py-pip build-base \
    && rm -rf /var/cache/apk/*

RUN addgroup -S labgroup \
    && adduser -S labuser -G labgroup \
    && chmod a+x /entrypoint.sh

USER labuser
WORKDIR /home/labuser

RUN pip install awscli --upgrade --user

ENTRYPOINT /entrypoint.sh && /bin/zsh


