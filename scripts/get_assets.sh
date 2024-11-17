#!/usr/bin/env bash

set -e;

ASSETS_DIR='assets';

ERROR_USAGE=-1;
PROBLEM_SET_NOT_FOUND=-2;

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

function get_week08_trivia {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/8/trivia.zip';
	local zip_file='trivia.zip';

	log_load_assets '08' '"Trivia"';
	download_zip_assets $file_uri $zip_file;
}

function get_week08_homepage {
	local file_uri='https://cdn.cs50.net/2023/fall/psets/8/homepage.zip';
	local zip_file='homepage.zip';

	log_load_assets '08' '"Homepage"';
	download_zip_assets $file_uri $zip_file;
}

function get_all {
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

	get_week08_trivia;
	get_week08_homepage;
}

function invalid_problem_set {
	echo "problem set \"$1\" in week \"$2\" not found";
	echo "available problem set for this week: $3";
	exit $PROBLEM_SET_NOT_FOUND;
}

mkdir --parents $ASSETS_DIR;

case $1 in
	'all')
		get_all;
		;;
	'w3')
		case $2 in
			'sort')
				get_week03_sort;
				;;
			'plurality')
				get_week03_plurality;
				;;
			'runoff')
				get_week03_runoff;
				;;
			'tideman')
				get_week03_tideman;
				;;
			*)
				invalid_problem_set "${2:-}" $1 "sort, plurality, runoff, tideman";
				;;
		esac
		;;
	'w4')
		case $2 in
			'volume')
				get_week04_volume;
				;;
			'filter-less')
				get_week04_filter_less;
				;;
			'filter-more')
				get_week04_filter_more;
				;;
			'recover')
				get_week04_recover;
				;;
			*)
				invalid_problem_set "${2:-}" $1 "volume, filter-less, filter-more, recover";
				;;
		esac
		;;
	'w5')
		case $2 in
			'inheritance')
				get_week05_inheritance;
				;;
			'speller')
				get_week05_speller;
				;;
			*)
				invalid_problem_set "${2:-}" $1 "inheritance, speller";
				;;
		esac
		;;
	'w6')
		case $2 in
			'dna')
				get_week06_dna;
				;;
			*)
				invalid_problem_set "${2:-}" $1 "dna";
				;;
		esac
		;;
	'w7')
		case $2 in
			'songs')
				get_week07_songs;
				;;
			'movies')
				get_week07_movies;
				;;
			'fiftyville')
				get_week07_fiftyville;
				;;
			*)
				invalid_problem_set "${2:-}" $1 "songs, movies, fiftyville";
				;;
		esac
		;;
	'w8')
		case $2 in
			'trivia')
				get_week08_trivia;
				;;
			'homepage')
				get_week08_homepage;
				;;
			*)
				invalid_problem_set "${2:-}" $1 "trivia";
				;;
		esac
		;;
	*)
		echo 'Usage: get_assets.sh <week|all> <problem_set>';
		exit $ERROR_USAGE;
		;;
esac
