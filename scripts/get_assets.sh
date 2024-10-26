#!/usr/bin/env bash

set -e;

ASSETS_DIR='assets';

function download {
	wget --quiet --show-progress $1 --output-document $2;
}

function unzip_assets {
	unzip -o $@ -d $ASSETS_DIR;
}

function download_zip_assets {
	rm -rf $2;
	download $1 $2;
	unzip_assets $2 $3;
	rm -rf $2;
}

function log_load_assets {
	echo -en "Loading Week $1 - $2 assets:\n";
}

function log_finished {
	echo 'done';
}

function get_week03_sort {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/3/sort.zip';
	local zip_file='sort.zip';

	log_load_assets '03' '"Sort"';
	download_zip_assets $file_uri $zip_file;
}

function get_week03_plurality {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/3/plurality.zip';
	local zip_file='plurality.zip';

	log_load_assets '03' '"Plurality"';
	download_zip_assets $file_uri $zip_file;
}

function get_week03_runoff {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/3/runoff.zip';
	local zip_file='runoff.zip';

	log_load_assets '03' '"Runoff"';
	download_zip_assets $file_uri $zip_file;
}

function get_week03_tideman {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/3/tideman.zip';
	local zip_file='tideman.zip';

	log_load_assets '03' '"Tideman"';
	download_zip_assets $file_uri $zip_file;
}

function get_week04_volume {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/4/volume.zip';
	local zip_file='volume.zip';
	local vol_wav_file='input.wav';

	log_load_assets '04' '"Volume"';
	download_zip_assets $file_uri $zip_file "volume/$vol_wav_file";
}

function get_week04_filter_less {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/4/filter-less.zip';
	local zip_file='filter-less.zip';

	log_load_assets '04' '"Filter less"';
	download_zip_assets $file_uri $zip_file;
}

function get_week04_filter_more {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/4/filter-more.zip';
	local zip_file='filter-more.zip';

	log_load_assets '04' '"Filter more"';
	download_zip_assets $file_uri $zip_file;
}

function get_week04_recover {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/4/recover.zip';
	local zip_file='recover.zip';

	log_load_assets '04' '"Recover"';
	download_zip_assets $file_uri $zip_file;
}

function get_week05_inheritance {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/5/inheritance.zip';
	local zip_file='inheritance.zip';

	log_load_assets '05' '"Inheritance"';
	download_zip_assets $file_uri $zip_file;
}

function get_week05_speller {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/5/speller.zip';
	local zip_file='speller.zip';

	log_load_assets '05' '"Speller"';
	download_zip_assets $file_uri $zip_file;
}

function get_week06_dna {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/6/dna.zip';
	local zip_file='dna.zip';

	log_load_assets '06' '"DNA"';
	download_zip_assets $file_uri $zip_file;
}

function get_week07_songs {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/7/songs.zip';
	local zip_file='songs.zip';

	log_load_assets '07' '"Songs"';
	download_zip_assets $file_uri $zip_file;
}

function get_week07_movies {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/7/movies.zip';
	local zip_file='movies.zip';

	log_load_assets '07' '"Movies"';
	download_zip_assets $file_uri $zip_file;
}

function get_week07_fiftyville {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/7/fiftyville.zip';
	local zip_file='fiftyville.zip';

	log_load_assets '07' '"Fiftyville"';
	download_zip_assets $file_uri $zip_file;
}


mkdir --parents $ASSETS_DIR;

get_week03_sort;
get_week03_plurality;
get_week03_runoff;
get_week03_tideman;

get_week04_volume;
get_week04_filter_less;
get_week04_filter_more;
get_week04_recover;

get_week05_inheritance;
get_week05_speller;

get_week06_dna;

get_week07_songs;
get_week07_movies;
get_week07_fiftyville;

log_finished;
