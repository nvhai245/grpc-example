FROM golang:alpine as build-env

ENV GO111MODULE=on

RUN apk update && apk add bash ca-certificates git gcc g++ libc-dev

RUN mkdir /grpc-example
RUN mkdir -p /grpc-example/proto

WORKDIR /grpc-example

COPY ./proto/service.pb.go /grpc-example/proto
COPY ./main.go /grpc-example

COPY go.mod .
COPY go.sum .

RUN go mod download

RUN go build -o grpc-example .

CMD ./grpc-example