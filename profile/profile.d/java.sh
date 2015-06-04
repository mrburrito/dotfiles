function maven_opts {
	J8_MAVEN_OPTS="-Xmx2g"
	J6_MAVEN_OPTS="$J8_MAVEN_OPTS -XX:MaxPermSize=512m"
	# Configure Maven options based on Java version; Java >= 1.8 does not support -XX:MaxPermGen
	if type -p java 2>&1 > /dev/null; then
		_java=java
	elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]]; then
		_java="$JAVA_HOME/bin/java"
	else
		echo "No Java Found"
	fi
	if [[ "$_java" ]]; then
		# Configures version as ${major}${minor} (e.g. 16, 18, 110, etc.) for simple comparisonss
		JAVA_VERSION=$("$_java" -version 2>&1 | sed 's/java version "\(.*\)\.\(.*\)\..*"/\1\2/; 1q')
		if [[ "$JAVA_VERSION" < "18" ]]; then
			MAVEN_OPTS=$J6_MAVEN_OPTS
		else
			MAVEN_OPTS=$J8_MAVEN_OPTS
		fi
	fi
	export MAVEN_OPTS
}

alias jv='java -version'
function switch_java {
	export JAVA_HOME=`/usr/libexec/java_home -v $1`
	maven_opts
	java -version
}

JAVA_VERSIONS=`/usr/libexec/java_home -V 2>&1 | grep -E "^ +[0-9]" | sed 's/^ *//' | cut -f 1,2 -d '.' | uniq`
for version in $JAVA_VERSIONS; do
	minor=`echo $version | cut -f 2 -d '.'`
	set_alias="alias j$minor='switch_java $version'"
	eval $set_alias
#	$(alias j$minor=$cmd)
done

M2_HOME=/usr/local/maven
export M2_HOME
export PATH=$M2_HOME/bin:$PATH
maven_opts
