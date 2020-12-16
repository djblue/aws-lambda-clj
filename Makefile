NAMESPACE = example.core
FUNCTION = clojure-lambda
JAR = aws-lambda-clj.jar

clean:
	rm -rf classes ${JAR}

compile:
	mkdir -p classes
	clojure -M -e "(compile '${NAMESPACE})"

jar:
	clojure -M:uberjar \
		-m uberdeps.uberjar \
		--main-class ${NAMESPACE} \
		--target ${JAR}

run:
	time java -cp `clj -Spath` ${NAMESPACE}

deploy:
	aws lambda create-function \
		--function-name ${FUNCTION} \
		--zip-file fileb://${JAR} \
		--handler ${NAMESPACE}::handleRequest \
		--runtime java11

invoke:
	aws lambda invoke \
		--function-name ${FUNCTION} out \
		--log-type Tail
