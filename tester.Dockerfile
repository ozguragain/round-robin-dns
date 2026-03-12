FROM rockylinux/rockylinux:10
RUN dnf install -y bind-utils curl && dnf clean all