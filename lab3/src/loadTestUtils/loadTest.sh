rm -rf load_test

for run in {1..5};
do
python client/main.py --num_requests=$1 --out_file_idx=$run --order_prob=$2 --hostname=$3 --port=$4&
done
wait
awk 'FNR==1&&NR!=1{print ""}1' load_test/lookup/* > load_test/lookup/intmdResult
awk 'NF' load_test/lookup/intmdResult > load_test/lookup/combinedResult
awk 'FNR==1&&NR!=1{print ""}1' load_test/orders/* > load_test/orders/intmdResult
awk 'NF' load_test/orders/intmdResult > load_test/orders/combinedResult
awk 'FNR==1&&NR!=1{print ""}1' load_test/ordersVerif/* > load_test/ordersVerif/intmdResult
awk 'NF' load_test/ordersVerif/intmdResult > load_test/ordersVerif/combinedResult
awk -f loadTestUtils/findMean.awk load_test/lookup/combinedResult > load_test/lookup/averageResponseTime
awk -f loadTestUtils/findMean.awk load_test/orders/combinedResult > load_test/orders/averageResponseTime
awk -f loadTestUtils/findMean.awk load_test/ordersVerif/combinedResult > load_test/ordersVerif/averageResponseTime