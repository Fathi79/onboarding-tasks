FROM python:3.10-slim

ENV ROBOT_OPTIONS="--outputdir /tests/results"

WORKDIR /tests

COPY . /tests

RUN pip install --no-cache-dir -r requirements.txt

CMD ["robot", "--outputdir", "results", "tests/"]
