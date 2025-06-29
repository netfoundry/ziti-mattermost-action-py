FROM python:3.11-bullseye

RUN pip install --target=/app requests openziti

# https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/python3-debian12
COPY --from=builder /app /app
COPY ./zhook.py /app/zhook.py
WORKDIR /app
COPY ./zhook.py /app/zhook.py

RUN pip install --no-cache-dir requests openziti

ENV PYTHONPATH=/app
#ENV ZITI_LOG=6
#ENV TLSUV_DEBUG=6

CMD ["python", "/app/zhook.py"]
