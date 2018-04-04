import sys
import random 
import itertools

def main(n):
    file = open('hw11-data-' + str(n) + '.sql', 'w')
    file.write('INSERT INTO Employee VALUES')
    for i in range (1, n+1):
        endChar = ','
        if (i == n):
           endChar = ';'
        file.write('(' + str(i) + ', ' + str(getSalary()) + ', "' + getTitle() + '")' + endChar)
    file.close()

def getSalary():
    return (random.randint(12000, 150000))

def getTitle():
    titles = ['engineer', 'manager', 'salesperson', 'administrator']
    return titles[random.randint(0, 3)]

if __name__ == '__main__':
    main(int(sys.argv[1]))