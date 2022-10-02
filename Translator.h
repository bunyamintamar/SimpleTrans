#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include <QString>

class Translator
{
public:
    static void translate(const QString &to, QString &text);

private:
    static void removeSpaces(QString &text);
    static void quotesToApostrophe(QString &text);
    static void apostropheToQuotes(QString &text);
    static QString translateCmd(const QString &to, const QString &text);
    static QString outputOfCmd(const QString cmd);
    static void result(QString &text);
};

#endif // TRANSLATOR_H
