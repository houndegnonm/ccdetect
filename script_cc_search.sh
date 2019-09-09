rm -rf /root/result.log*
rm -rf /root/raw_data.log
rm -rf /root/creditCard.log
curl -u es_admin:qMHV%7nE#w8X47yY -XGET 'https://es-cdr-prod-client-new.dialogtech.com/_cat/indices' | while read indices;
do {

        indice=$(echo $indices | cut -d' ' -f 3);

        #indice="v7_cdr_calls_201904"
        if [ $indice == "4zqrej0-TJ6csXkRZqdXxA" ]; then
                indice=$(echo $indices | cut -d' ' -f 2);
        elif [ $indice == "JhfnAa2CR4eOG7JUYrtjWw" ]; then
                indice=$(echo $indices | cut -d' ' -f 2);
        fi

        echo "################# scanning ES Indice $indice #########################"  >> /root/result.log
curl -u es_admin:qMHV%7nE#w8X47yY -XGET "https://es-cdr-prod-client-new.dialogtech.com/$indice/_search?pretty&filter_path=hits.total,hits.hits._source.speech.in" -H 'Content-Type: application/json' -d '{
"_source": "speech.in",
 "query": {
    "bool": {
      "should": [
        {
          "match": {
            "speech.in": "Visa"
          }
        },
        {
          "match": {
            "speech.in": "Discover"
          }
        },
        {
          "match": {
            "speech.in": "Mastercard"
          }
        },
        {
          "match": {
            "speech.in": "Amex"
          }
        },
        {
          "match_phrase": {
            "speech.in": "American express"
          }
        },
        {
          "match_phrase": {
            "speech.in": "Bank card"
          }
        },
        {
          "match_phrase": {
            "speech.in": "Credit card"
          }
        },
        {
          "match_phrase": {
            "speech.in": "Debit card"
          }
        },
        {
          "match": {
            "speech.in": "Card"
          }
        },
        {
          "match": {
            "speech.in": "Ccv"
          }
        },
        {
          "match": {
            "speech.in": "Cvv"
          }
        },
        {
          "match": {
            "speech.in": "Cvc"
          }
        },
        {
          "match": {
            "speech.in": "Cvv2"
          }
        },
        {
          "match_phrase": {
            "speech.in": "Security code"
          }
        },
        {
          "match": {
            "speech.in": "Secret"
          }
        },
        {
          "match": {
            "speech.in": "Pin"
          }
        },
        {
          "match_phrase": {
            "speech.in": "Digits on the back"
          }
        },
        {
          "match_phrase": {
            "speech.in": "Expiration date"
          }
        },
        {
          "match_phrase": {
            "speech.in": "Expiration"
          }
        },
        {
          "match_phrase": {
            "speech.in": "car number"
          }
        }

      ]
    }
  }
}' >> /root/result.log

}; < /dev/null; done

sed -i -e 's/zero/0/g ;  s/one/1/g ; s/two/2/g ; s/three/3/g ; s/four/4/g ; s/five/5/g ; s/six/6/g ; s/seven/7/g ; s/eight/8/g ; s/nine/9/g ;  s/ //g'  /root/result.log
./ccsrch -o /root/creditCard.log /root/result.log
