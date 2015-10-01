#!/usr/bin/env python
# encoding: utf-8
"""
Translate CSV files into MySQL tables.
Borrowed a good bit of codes from this project https://github.com/maxhodak/csv2sql
"""

import MySQLdb
import csv
import argparse


class csv2mysql(object):

    def __init__(self, filename):
        super(csv2mysql, self).__init__()

        self.filename = filename
        tmp = filename.split('.')[0]
        if '/' in tmp:
            tmp = tmp.split('/')[-1:][0]
        self.tablename = tmp
        self.csvfile = open(filename)

        self.dialect = csv.Sniffer().sniff(self.csvfile.read(128))
        self.csvfile.seek(0)

        self.csvreader = csv.reader(self.csvfile, self.dialect)
        self.headers = self.csvreader.next()
        self.headers = [header.split(':')[0] for header in self.headers]
        self.types = dict([(header, 'BIGINT') for header in self.headers])

    def isFloat(self, x):
        try:
            float(x)
            return True
        except ValueError:
            return False

    def isInteger(self, x):
        if x == '' or x is None:
            return True
        try:
            int(x)
            return True
        except:
            return False

    def generate(self):
        for x in xrange(500):
            row = self.csvreader.next()
            for i, header in enumerate(self.headers):
                col = row[i]
                if self.types[header] == 'BIGINT':
                    if not self.isInteger(col):
                        self.types[header] = 'DOUBLE'
                if self.types[header] == 'DOUBLE':
                    if not self.isFloat(col):
                        self.types[header] = 'VARCHAR(255)'

    def buildCreateTable(self, db, table):
        sql = "CREATE TABLE IF NOT EXISTS `{0}`.`{1}` (\n".format(db, table)
        for header in self.headers:
            sql = sql + "  `{0}` \t {1},\n".format(header, self.types[header])
        sql = sql[:-2]
        sql += "\n);"
        return sql

    def buildInserts(self):
        sql = ""
        self.csvfile.seek(0)
        self.csvreader = csv.reader(self.csvfile, self.dialect)
        self.csvreader.next()
        for row in self.csvreader:
            sql += "INSERT INTO `"+self.tablename+"` VALUES ("
            for col in row:
                sql += "'"+col.replace('"', '\"').replace("'", "\\'")+"',"
            sql = sql[:-1]
            sql += ");\n"
        return sql


def args():
    parser = argparse.ArgumentParser(description="Load CSV dataset into MySQL table.")
    parser.add_argument('csv_file', help='CSV file path', type=str)
    parser.add_argument('db_table', help='Table to CREATE in Health DB', type=str)
    parser.add_argument('db_host', help='DB host', type=str)
    parser.add_argument('db_user', help='DB user', type=str)
    parser.add_argument('password', help='DB user\'s password', type=str)
    return parser.parse_args()


def main():
    health_db = 'health_db_internet'
    a = args()

    conn = MySQLdb.connect(host=a.db_host,
                           port=3306,
                           user=a.db_user,
                           db=health_db,
                           passwd=a.password)

    # Create object for translating CSV to SQL creation statements
    builder = csv2mysql(a.csv_file)
    builder.generate()
    # import code; code.interact(local=locals())

    with conn as cursor:
        create_table_stmt = builder.buildCreateTable(health_db, a.db_table)
        print create_table_stmt
        cursor.execute(create_table_stmt)


if __name__ == '__main__':
    main()
