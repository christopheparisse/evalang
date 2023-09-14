#conda activate t2k_env_M1
cd ~/brainstorm/text-to-kids/wp3/text_complexity_client/src
python text_complexity_client_cmd.py --tcof --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-long-mdd.csv -p mdd ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/long
python text_complexity_client_cmd.py --tcof --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-philo-mdd.csv -p mdd ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/philo
python text_complexity_client_cmd.py --tcof --output ~/brainstorm/evalang/evalang-public/statistics/chi-TCOF-trans-mdd.csv -p mdd ~/brainstorm/evalang/evalang-public/tcof/rawtextchi/trans

python text_complexity_client_cmd.py --tcof --output ~/brainstorm/evalang/evalang-public/statistics/adu-TCOF-mdd.csv -p mdd ~/brainstorm/evalang/evalang-public/tcof/rawtextadu
