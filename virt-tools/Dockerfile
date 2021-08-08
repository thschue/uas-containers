ARG ALPINE_VERSION=latest

FROM alpine:${ALPINE_VERSION} as builder

ARG TERRAFORM_VERSION=1.0.4
ARG GCLOUD_SDK_VERSION=351.0.0

RUN apk add --no-cache curl bash python3

RUN mkdir /tmp/terraform \
   && curl -Lo /tmp/terraform/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
   && unzip /tmp/terraform/terraform.zip -d /tmp/terraform \
   && ls /tmp/terraform \
   && chmod a+x /tmp/terraform/terraform

RUN mkdir -p /tmp/gcloud \
   && curl -Lo /tmp/gcloud/gcloud_sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
   && tar -C /tmp/gcloud -xzf /tmp/gcloud/gcloud_sdk.tar.gz \
   && rm /tmp/gcloud/gcloud_sdk.tar.gz

FROM alpine:${ALPINE_VERSION}

ENV PATH="/opt/gcloud/google-cloud-sdk/bin:/home/labuser/.local/bin:${PATH}"

COPY .zshrc.template /tmp/.zshrc.template
COPY entrypoint.sh /entrypoint.sh
COPY --from=builder /tmp/gcloud /opt/gcloud
COPY --from=builder /tmp/terraform/terraform /usr/local/bin/terraform

RUN apk add --no-cache bash zsh python3 curl git py-pip \
    && rm -rf /var/cache/apk/*

RUN addgroup -S labgroup \
    && adduser -S labuser -G labgroup \
    && chmod a+x /entrypoint.sh

USER labuser
WORKDIR /home/labuser

RUN pip install awscli --upgrade --user

ENTRYPOINT /entrypoint.sh && /bin/zsh


