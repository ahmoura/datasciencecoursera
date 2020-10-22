import sys
import json
import itertools

def load_and_split(tweet_file, sent_file):
    scores = {}
    for l in sent_file:
        term, score  = l.split('\t')
        scores[term.lower()] = int(score)
    for l in tweet_file:
        tweet=json.loads(l)
        #print tweet['text'].encode('utf-8', 'ignore')
        words=tweet['text'].lower().split()
        s=0
        for i in xrange(0,len(words)-2):
            phs=' '.join(words[i:i+3])
            if phs in scores: s+=scores[phs]
        for i in xrange(0,len(words)-1):
            phs=' '.join(words[i:i+2])
            if phs in scores: s+=scores[phs]
        for w in words:
            if w in scores: s+=scores[w]
        print s

def lines(fp):
    print str(len(fp.readlines()))

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    load_and_split(tweet_file, sent_file)
    #lines(sent_file)
    #lines(tweet_file)

if __name__ == '__main__':
    main()