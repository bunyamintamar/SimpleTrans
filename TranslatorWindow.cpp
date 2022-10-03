#include "TranslatorWindow.h"
#include "ui_TranslatorWindow.h"
#include "Translator.h"
#include <QDialog>
#include <QLabel>

#define ENG_FLAG "border-image: url(:/rsrc/engFlag.png);"
#define TR_FLAG  "border-image: url(:/rsrc/trFlag.png);"

TranslatorWindow::TranslatorWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::TranslatorWindow)
{
    ui->setupUi(this);
    changeEngToTr();
}

TranslatorWindow::~TranslatorWindow()
{
    delete ui;
}

void TranslatorWindow::translate()
{
    QString text = ui->textEdit->toPlainText();
    QString targetLang = m_isEngToTr ? "tr" : "eng";
    Translator::translate(targetLang, text);
    ui->textBrowser->setText(text);
}

void TranslatorWindow::changeEngToTr()
{
    ui->sourceFlag->setStyleSheet(ENG_FLAG);
    ui->targetFlag->setStyleSheet(TR_FLAG);
    m_isEngToTr = true;
}

void TranslatorWindow::changeTrToEng()
{
    ui->sourceFlag->setStyleSheet(TR_FLAG);
    ui->targetFlag->setStyleSheet(ENG_FLAG);
    m_isEngToTr = false;
}

void TranslatorWindow::changeTextRightToLeft()
{
    QString s_text = ui->textBrowser->toPlainText();
    QString t_text = ui->textEdit->toPlainText();

    ui->textEdit->setText(s_text);
    ui->textBrowser->setText(t_text);
}

void TranslatorWindow::showAbout()
{
    QDialog *dialog = new QDialog(this);
    dialog->setWindowTitle("About");
    dialog->setFixedSize(300, 150);

    QVBoxLayout *vlayout = new QVBoxLayout;
    dialog->setLayout(vlayout);

    QString text;
    text.append(APP_NAME).append(" ").append(APP_VERSION);
    text.append("\nby ").append(AUTHOR);
    text.append("\n").append(AUTHOR_MAIL);
    QLabel *label = new QLabel(text);
    label->setAlignment(Qt::AlignHCenter);

    QString link;
    link.append("<a href=\"http://").append(GITHUB_LINK).append("\">\nGitHub page</a>");
    QLabel *linkLabel = new QLabel(link);
    linkLabel->setAlignment(Qt::AlignHCenter);
    linkLabel->setOpenExternalLinks(true);

    vlayout->addWidget(label);
    vlayout->addWidget(linkLabel);

    dialog->show();
}

void TranslatorWindow::on_changeLang_clicked()
{
    if (!ui->textBrowser->toPlainText().isEmpty())
        changeTextRightToLeft();

    if (m_isEngToTr)
        changeTrToEng();
    else
        changeEngToTr();

    if (!ui->textEdit->toPlainText().isEmpty())
        translate();
}

void TranslatorWindow::on_translate_clicked()
{
    if (!ui->textEdit->toPlainText().isEmpty())
        translate();
}

void TranslatorWindow::on_aboutButton_clicked()
{
    showAbout();
}

void TranslatorWindow::on_clearButton_clicked()
{
    ui->textEdit->clear();
    ui->textBrowser->clear();
}

