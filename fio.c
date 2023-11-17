/*****************************************************************************/
/* Fio.c                                                                   */
/*                                                                           */
/* Programa que lê o microfone e envia para o alto falante                             */
/*                                                                           */
/*****************************************************************************/

#include <type.h>
#include <board.h>
#include <codec.h>
#include <mcbsp54.h>

/*****************************************************************************/
/* Global Variables                                                          */
/*****************************************************************************/

HANDLE hHandset;
s16 data;        /* variavel usada receber as amostras lidas */

/*****************************************************************************/
/* MAIN                                                                      */
/*****************************************************************************/
	
void main()
{
   if (brd_init(100))   /* inicializa o cartão */
        return;

    /* aloca um handle para o Codec */
    hHandset = codec_open(HANDSET_CODEC);               /* recebe um handle para o codec */

    /* configura os parametros do codec */
    codec_dac_mode(hHandset, CODEC_DAC_15BIT);          /* DAC in 15-bit mode */
    codec_adc_mode(hHandset, CODEC_ADC_15BIT);          /* ADC in 15-bit mode */
    codec_ain_gain(hHandset, CODEC_AIN_12dB);            /* 6dB gain on analog input to ADC */
    codec_aout_gain(hHandset, CODEC_AOUT_MINUS_0dB);    /* -6dB gain on analog output from DAC */
    codec_sample_rate(hHandset,SR_16000);               /* 16KHz sampling rate */


    /* lê e escreve em loop infinito */
    while (1)
    {
       /* espera uma amostra da entrada do microfone */
       while (!MCBSP_RRDY(HANDSET_CODEC)) {};

       /* lê amostra e envia para a saida do codec */
       data = *(volatile u16*)DRR1_ADDR(HANDSET_CODEC) * 10;
       *(volatile u16*)DXR1_ADDR(HANDSET_CODEC) = data;
    }
}

