#!/usr/bin/env bash

alias jv='java -version'
function switch_java {
	export JAVA_HOME=`/usr/libexec/java_home -v $1`
	java -version
}

JAVA_VERSIONS=`/usr/libexec/java_home -V 2>&1 | grep -E "^ +[0-9]" | sed 's/^ *//' | cut -f 1,2 -d '.' | uniq`
for version in ${JAVA_VERSIONS}; do
  major=`echo ${version} | cut -f 1 -d '.' | cut -f 1 -d ','`
	minor=`echo ${version} | cut -f 2 -d '.'`
  if [[ ${major} -gt 1 ]]; then
 	  set_alias="alias j${major}='switch_java ${version}'"
  else
	  set_alias="alias j${minor}='switch_java ${version}'"
  fi
	eval ${set_alias}
done

export MAVEN_OPTS="-Xmx2g"
