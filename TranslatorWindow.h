#ifndef TRANSLATORWINDOW_H
#define TRANSLATORWINDOW_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class TranslatorWindow; }
QT_END_NAMESPACE

class TranslatorWindow : public QMainWindow
{
    Q_OBJECT

public:
    TranslatorWindow(QWidget *parent = nullptr);
    ~TranslatorWindow();

private:
    void translate();
    inline void changeEngToTr();
    inline void changeTrToEng();
    inline void changeTextRightToLeft();
    void showAbout();

private slots:
    void on_changeLang_clicked();
    void on_translate_clicked();
    void on_aboutButton_clicked();
    void on_clearButton_clicked();

private:
    Ui::TranslatorWindow *ui;
    bool m_isEngToTr;
};
#endif // TRANSLATORWINDOW_H
