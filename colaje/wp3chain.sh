conda activate t2k_env_M1
cd ~/brainstorm/text-to-kids/wp3/text_complexity_client/src
python text_complexity_client_cmd.py --output ../chi-COLAJE-text.csv --text --noage ~/brainstorm/evalang/evalang-public/colaje/rawtextchi
python text_complexity_client_cmd.py --output ../chi-COLAJE-sentence.csv --sentence --noage ~/brainstorm/evalang/evalang-public/colaje/rawtextchi
