import sys
import json
import re

def lines(fp):
    tweets = []
    for line in fp.readlines():
        tweet = json.loads(line)
        text = tweet.get('text')
        if text:
            text.strip()
            tweets.append(text)
    return tweets

def compute_sentiments(lines, scores):
    sentiments = []
    for line in lines:
        i = line_score = 0
        line_words = line.split()
        line_words = [re.sub(r'\W+', '', w) for w in line_words]
        while i < len(line_words):
            match = line_words[i:]
            unmatched = []
            unmatched_flag = 0 # if stays with 0, the word doesnt match with anything
            for word in match:
                for key in scores.keys():
                    if (word.lower() == key):
                        line_score += scores[key]
                        i += len(word)
                        unmatched_flag = 1
                    else:
                        i += 1
                if (unmatched_flag == 0):
                    unmatched.append(word)

        sentiments.append([line, line_score, unmatched])    
    return sentiments

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    tweets = lines(tweet_file)

    scores = {} # initialize an empty dictionary
    for line in sent_file:
        term, score  = line.split("\t")
        scores[term] = int(score)

    sentiments = compute_sentiments(tweets, scores)

    [print(sentiments[i][1]) for i in range(len(sentiments))]
        


if __name__ == '__main__':
    main()
