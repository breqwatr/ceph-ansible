FROM ubuntu:bionic

ARG RELEASE

RUN mkdir -p \
      /root/.ssh \
      /var/repos/ \
  && apt-get update \
  && apt-get install -y \
      ansible \
      ceph-common \
      git \
      iputils-ping \
      net-tools \
      python2.7 \
      python-dev \
      python-pip \
      python-setuptools \
  && rm -rf /var/lib/apt/lists/* \
  && git clone \
      --single-branch --branch stable-$RELEASE \
      https://github.com/ceph/ceph-ansible.git /var/repos/ceph-ansible \
  && rm /var/repos/ceph-ansible/group_vars/*.sample \
  && cp /var/repos/ceph-ansible/site.yml.sample /var/repos/ceph-ansible/site.yml \
  && pip install -r /var/repos/ceph-ansible/requirements.txt

COPY image-files/ /
