FROM docker.io/library/golang:latest as build
WORKDIR /argocon
COPY . /argocon
COPY ui /argocon/ui
RUN CGO_ENABLED=0 GOOS=linux go build -installsuffix cgo -o ./app .

FROM busybox
COPY --from=0 /argocon/app .
COPY --from=0 /argocon/ui/ ui
EXPOSE 8080
CMD ["/app"]
