#conda activate t2k_env_M1
cd ~/brainstorm/text-to-kids/wp3/text_complexity_client/src
python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-long-text.csv --text --noage ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/long
python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-philo-text.csv --text --noage ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/philo

python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-long-sentence.csv --sentence --noage ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/long
python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-philo-sentence.csv --sentence --noage ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/philo

python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-trans.csv --noage ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/trans

python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-trans-text.csv --text --noage ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/trans
python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-trans-sentence.csv --sentence --noage ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/trans


python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/adu-TCOF-text.csv --text --noage ~/brainstorm/evalang/evalang-public/tcof/rawtextadu
python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/adu-TCOF-sentence.csv --sentence --noage ~/brainstorm/evalang/evalang-public/tcof/rawtextadu


python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-long-allmdd.csv --allmdd ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/long
python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-philo-allmdd.csv --allmdd ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/philo
python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-trans-allmdd.csv --allmdd ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/trans

python text_complexity_client_cmd.py --output ~/brainstorm/evalang/evalang-public/statistics/adu-TCOF.csv --allmdd ~/brainstorm/evalang/evalang-public/tcof/rawtextadu
