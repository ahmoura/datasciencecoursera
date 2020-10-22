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

def word_scores(lines, scores):
    w_score = []
    for line in lines:
        i = 0
        line_words = line.split()
        line_words = [re.sub(r'\W+', '', w) for w in line_words]
        while i < len(line_words):
            match = line_words[i:]
            line_words = []
            unmatched_flag = 0 # if stays with 0, the word doesnt match with anything
            for word in match:
                for key in scores.keys():
                    if (word.lower() == key):
                        line_words.append([key, scores[key]])
                        i += len(word)
                    else:
                        i += 1

        w_score.append([line, line_words])    
    return w_score

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    tweets = lines(tweet_file)

    scores = {} # initialize an empty dictionary
    for line in sent_file:
        term, score  = line.split("\t")
        scores[term] = int(score)

    w_score = word_scores(tweets, scores)

    [print(w_score[i][1]) for i in range(len(w_score))]
        


if __name__ == '__main__':
    main()
