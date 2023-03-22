FROM registry.access.redhat.com/ubi8/go-toolset:1.17.7 as builder

USER root
WORKDIR /workspace
COPY . .
RUN go build -o myserver server.go

FROM registry.access.redhat.com/ubi8/ubi-minimal

LABEL MAINTAINER "Flavius Lacatusu <flacatus@redhat.com>"

COPY --from=builder /workspace/myserver /usr/bin/myserver

EXPOSE 8081/tcp

ENTRYPOINT ["myserver"]
