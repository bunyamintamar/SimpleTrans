#include "Translator.h"

#include <QDebug>
#include <QProcess>

void Translator::translate(const QString &to, QString &text)
{
    quotesToApostrophe(text);
    removeSpaces(text);
    text = outputOfCmd(translateCmd(to, text));
    removeSpaces(text);
    result(text);
    apostropheToQuotes(text);
}

void Translator::removeSpaces(QString &text)
{
    text.replace("\n", " ");
    text.replace("   ", " ");
    text.replace("  ", " ");
}

void Translator::quotesToApostrophe(QString &text)
{
    text.replace("\"", "\'\'");
}

void Translator::apostropheToQuotes(QString &text)
{
    text.replace("\'\'", "\"");
}

QString Translator::translateCmd(const QString &to, const QString &text)
{
    return QString(TRANSLATE_SHELL_PATH) + "/trans :" + to + " \"" + text + "\"";
}

QString Translator::outputOfCmd(const QString cmd)
{
    QString ret;
    QProcess process;

    process.start(cmd);
    process.waitForFinished();
    ret = process.readAllStandardOutput().trimmed();
    process.close();

    return ret;
}

void Translator::result(QString &text)
{
    QString begin = "[1m";
    QString end   = "\u001B[22m";
    int iBegin    = text.indexOf(begin, 0) + begin.length();
    int iEnd      = text.indexOf(end, iBegin);

    text = text.mid(iBegin, iEnd - iBegin);
}
