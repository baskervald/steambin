#!/bin/bash

steamapps_dir=${STEAMAPPS_DIR:-~/.local/share/Steam/steamapps}
steambin_dir=${STEAMBIN_DIR:-~/.steambin}
steam_cmd=${STEAM_CMD:-steam}

parse_acf () {
  appid=
  name=
  while read -r line; do
    container=($(echo "$line" | grep -o '".*"' | tr -d '"'))
    if [ "${container[0]}" = "appid" ]; then
      appid=${container[1]}
    elif [ "${container[0]}" = "name" ]; then
      name="$(echo "${container[@]:1}" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^A-Za-z0-9-]//g')"
    fi
  done < $1

  # return
  for x in $name $appid; do
    echo $x
  done
}

make_executable () {
  file=$steambin_dir/$1
  echo '#!/bin/sh' > $file
  echo "$steam_cmd steam://run/$2" >> $file
  echo "$2 $1" >> $steambin_dir/.games
  chmod +x $file
}

handle_file () {
  container=($(parse_acf $1))
  make_executable ${container[0]} ${container[1]}
}

rm $steambin_dir/*
for file in $steamapps_dir/appmanifest_*.acf; do
  handle_file $file
done
