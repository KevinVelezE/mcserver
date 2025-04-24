FROM openjdk:17

WORKDIR /mc
COPY start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
