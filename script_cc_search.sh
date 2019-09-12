rm -rf /root/result.log*
rm -rf /root/creditCard.log
curl -u es_admin:qMHV%7nE#w8X47yY -XGET 'https://es-cdr-prod-client-new.dialogtech.com/_cat/indices/*2019*?' | while read indices; 
do {
	indice=$(echo $indices | cut -d' ' -f 3);
	
#	if [ $indice == "4zqrej0-TJ6csXkRZqdXxA" ]; then
#		indice=$(echo $indices | cut -d' ' -f 2);
#	elif [ $indice == "JhfnAa2CR4eOG7JUYrtjWw" ]; then
#		indice=$(echo $indices | cut -d' ' -f 2);
#	fi

	echo "################# scanning ES Indice $indice #########################"  >> /root/result.log
	curl -u es_admin:qMHV%7nE#w8X47yY -XGET "https://es-cdr-prod-client-new.dialogtech.com/$indice/_search?pretty&filter_path=hits.hits._id,hits.hits._source.speech.in" -H 'Content-Type: application/json' -d '{
    
    "query": {
        "bool": {
            "should": [
                [
                    {
                        "bool": {
                            "_name": "Caller-Found the word Credit",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "credit"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Agent-Found the word Credit",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "credit"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Caller-Found the word Card",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "card"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Agent-Found the word Card",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "card"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Caller-Credit or Debit",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "credit"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "debit"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Agent-Credit or Debit",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "credit"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "debit"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Caller-Transaction Indicators",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "gift card"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "credit card"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "debit card"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "bank card"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Agent-Transaction Indicators",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "gift card"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "credit card"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "debit card"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "bank card"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Caller-Major Credit Card Brands",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "visa"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "mastercard"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "master card"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "amex"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "american express"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "discover"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Agent-Major Credit Card Brands",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "visa"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "mastercard"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "master card"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "amex"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "american express"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "discover"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Caller-Expiration Indicators",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "expiration"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "expiration date"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "expiry"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "expires"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Agent-Expiration Indicators",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "expiration"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "expiration date"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "expiry"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "expires"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Caller-SAD Indicators",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "ccv"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "cvv"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "cvc"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "cvv2"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "security code"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "pin"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "digits on the back"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "number on the back"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.in": {
                                                        "query": "secret"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "bool": {
                            "_name": "Agent-SAD Indicators",
                            "must": [
                                {
                                    "bool": {
                                        "should": [
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "ccv"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "cvv"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "cvc"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "cvv2"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "security code"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "pin"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "digits on the back"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "number on the back"
                                                    }
                                                }
                                            },
                                            {
                                                "match_phrase": {
                                                    "speech.out": {
                                                        "query": "secret"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    }
                ]
            ]
        }
    },
    "_source": {
        "includes": [
            "acct_id",
            "sid",
            "date_added",
            "speech.in",
            "speech.out"
        ]
    }
}' >> /root/result.log
	#sed -i -e 's/zero/0/g ;  s/one/1/g ; s/two/2/g ; s/three/3/g ; s/four/4/g ; s/five/5/g ; s/six/6/g ; s/seven/7/g ; s/eight/8/g ; s/nine/9/g ;  s/ //g'  /root/result/$indice
	#./ccsrch -o /root/result/credit_card_$indice.log /root/result/$indice
}; < /dev/null; done
cp /root/result.log /root/result.log.old
sed -i -e 's/zero/0/g ;  s/one/1/g ; s/two/2/g ; s/three/3/g ; s/four/4/g ; s/five/5/g ; s/six/6/g ; s/seven/7/g ; s/eight/8/g ; s/nine/9/g ;  s/ //g'  /root/result.log
./ccsrch -o /root/creditCard.log /root/result.log
