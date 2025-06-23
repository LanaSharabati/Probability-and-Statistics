import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import accuracy_score
from scipy.stats import binom
import matplotlib.pyplot as plt
import numpy as np


df = pd.read_csv('spam_ham_dataset.csv')  
X = df["text"]
y = df["label_num"]  # 1 = spam, 0 = not spam

# Naive Bayes classifier
vectorizer = TfidfVectorizer(stop_words='english')
X_vect = vectorizer.fit_transform(X)
X_train, X_test, y_train, y_test = train_test_split(X_vect, y, test_size=0.2, random_state=42)


model = MultinomialNB()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
n = len(y_test)
k = int(accuracy * n)
p = accuracy

print("Accuracy:", round(p, 4))
print("Correct predictions:", k, "out of", n)

# Generate plots
x = np.arange(k - 15, k + 16)
pmf_vals = binom.pmf(x, n, p)


plt.figure(figsize=(10, 6))
plt.bar(x, pmf_vals, color='steelblue')
plt.axvline(k, color='red', linestyle='--', label=f'Observed: X = {k}')
plt.title('Probability Mass Function (PMF)')
plt.xlabel('Number of Correct Predictions')
plt.ylabel('P(X = x)')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()


cdf_vals = binom.cdf(x, n, p)
plt.figure(figsize=(10, 6))
plt.plot(x, cdf_vals, drawstyle='steps-post', color='darkgreen')
plt.axvline(k, color='red', linestyle='--', label=f'Observed: X = {k}')
plt.title('Cumulative Distribution Function (CDF)')
plt.xlabel('Number of Correct Predictions')
plt.ylabel('P(X ≤ x)')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()


threshold = k + 6
x_tail = np.arange(threshold, k + 16)
pmf_tail = binom.pmf(x_tail, n, p)

plt.figure(figsize=(10, 6))
plt.bar(x, pmf_vals, color='lightgray', label='P(X = x)')
plt.bar(x_tail, pmf_tail, color='dodgerblue', label=f'P(X ≥ {threshold})')
plt.axvline(k, color='red', linestyle='--', label=f'Observed: X = {k}')
plt.title(f'Tail Probability Highlight: P(X ≥ {threshold})')
plt.xlabel('Number of Correct Predictions')
plt.ylabel('P(X = x)')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()

tail_prob = 1 - binom.cdf(threshold - 1, n, p)
print(f"P(X ≥ {threshold}) = {round(tail_prob, 4)}")
